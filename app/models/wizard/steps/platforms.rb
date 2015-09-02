module Wizard
  module Steps
    class Platforms < Wizard::Step
      attr_accessor :platforms
      attr_accessor :hours_per_tester

      def self.available_platforms
        {
            browsers: {
                svg: "ie",
                subitems: ["Internet Explorer", "Firefox", "Chrome", "Safary"]
            },
            operation_systems: {
                svg: nil,
                subitems: [ "Windows 7", "Windows 8", "Mac OS X 10.9", "Mac OS X 10.10"]
            },
            ios: {
                svg: "apple",
                sibitems: [
                    "iPhone 3GS",
                    "iPhone 4",
                    "iPhone 4S",
                    "iPhone 5",
                    "iPhone 5c",
                    "iPhone 5S",
                    "iPhone 6",
                    "iPhone 6 Plus",
                    "iPad 2",
                    "iPad 3",
                    "iPad 4",
                    "iPad Air",
                    "iPad Air 2",
                    "iPad mini",
                    "iPad mini 2 with retina display",
                    "iPad mini 3",
                    "iPod touch 4th gen",
                    "iPod touch 5th gen"
                ]
            },
            android: {
                svg: "android",
                subitems: [
                    "Samsung Galaxy 2",
                    "Samsung Galaxy 3",
                    "Samsung Galaxy 4",
                    "Samsung Galaxy 5",
                    "Samsung Galaxy Note",
                    "Samsung Galaxy Note 2",
                    "Samsung Galaxy Note 3",
                    "Samsung Galaxy Ace",
                    "HTC One M8",
                    "HTC One X",
                    "HTC Desire HD",
                    "Motorola Moto X",
                    "Motorola Moto G",
                    "LG G2",
                    "LG G3",
                    "Sony Xperia Z",
                    "Google Nexus 4",
                    "Google Nexus 5",
                    "Google Nexus 7",
                    "Google Nexus 10",
                    "Samsung Galaxy Tab 2 - 7 inches",
                    "Samsung Galaxy Tab 2 - 10 inches",
                    "Samsung Galaxy Tab 3 - 7 inches",
                    "Samsung Galaxy Tab 3 - 10 inches",
                    "Samsung Galaxy Note - 8 inches"
                ]
            },
            windows_mobile: {
                svg: nil,
                subitems: [
                    "Nokia Lumia 520",
                    "Nokia Lumia 920",
                    "Nokia Lumia 620",
                    "Nokia Lumia 710",
                    "Nokia Lumia 800",
                    "Nokia Lumia 820",
                    "Nokia Lumia 720",
                    "Nokia Lumia 610",
                    "Nokia Lumia 900",
                    "HTC 8X / 8XT"
                ]
            },
            game_consoles: {
                svg: nil,
                subitems: [
                    "XBOX360",
                    "SonyPlay Station",
                    "PSP",
                    "iOS",
                    "Windows"
                ]
            }
        }
      end

      def self.platforms_by_product_type(product_type)

        platform_keys = self.platform_keys_by_product_type(product_type)
        available_platforms.select{|key, value| platform_keys.include?(key) }


      end

      def self.platform_keys_by_product_type(product_type)
        platforms_per_product_type = {
            mobile: [:ios, :android, :windows_mobile],
            website: [:browsers],
            software: [:operation_systems],
            games: [:ios, :android, :windows_mobile, :game_consoles]
        }

        return platforms_per_product_type[product_type.to_sym]


      end

      def self.available_options
        {
          platforms: self.available_platforms,

          hours_per_tester: [1, 2, 3, 4, 5]
        }
      end
    end
  end
end