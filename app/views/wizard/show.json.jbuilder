properties = %w(active_step_number auth_login auth_password authentication_required comment completed_at created_at current_step_id expected_tested_at exploratory_description hours_per_tester
id methodology_type percent_completed proceeded_steps_count product_type_id project_name project_url project_version state successful test_type_id test_type_name product_type_name tested_at updated_at user_id)



json.extract! @test do
  json.active_step_number
end