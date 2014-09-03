module ApplicationHelper
  def get_dashboard_name
    Company.return_name
  end
end
