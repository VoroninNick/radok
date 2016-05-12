class DynamicRouter
  def self.load
    pages = {}

    Pages.all_class_names.each do |page_class_name|
      page_class = page_class_name.constantize
      page_route_name = page_class_name.split("::").last.underscore
      page_controller = "pages"
      page_controller_action = page_route_name
      page = pages[page_route_name.to_sym] ||= { route_name: page_route_name, type: page_class_name, controller: page_controller, action: page_controller_action }
      page[:url] = page_class.default_url if page[:url].blank?
    end

    PagesController.actions.each do |action|
      page_route_name = action
      page_controller = "pages"
      page_controller_action = action
      pages[page_route_name.to_sym] ||= { route_name: page_route_name, controller: page_controller, action: page_controller_action }
    end

    Rails.application.class.routes.draw do
      pages.each do |page_key, page|

        page_class_name = page.delete :type
        page_class = page_class_name.try(&:constantize)
        disabled = page_class.try(&:disabled) || false
        page_url = page.delete :url
        page_url ||= page[:action].to_s
        ctrl = page.delete :controller
        action = page.delete :action
        route_name = page.delete :route_name
        page_controller_class_name = "#{ctrl}_controller".classify
        page_controller_class = page_controller_class_name.constantize
        initial_template = "#{ctrl}/#{action}"

        if !page_controller_class.actions.map(&:to_s).include?(action.to_s)
          action = :default
        end
        if !disabled
          match page_url, to: "#{ctrl}##{action}", as: route_name, via: [:get], defaults: { initial_template: initial_template, page_class_name: page_class_name }
        end
      end
    end
  end

  def self.reload
    Rails.application.class.routes_reloader.reload!
  end
end
