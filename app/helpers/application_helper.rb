module ApplicationHelper
  def status_label(status)
    case status
    when "pending"
      '<span class="badge bg-secondary">Pending</span>'.html_safe
    when "in_progress"
      '<span class="badge bg-primary">In Progress</span>'.html_safe
    when "blocked"
      '<span class="badge bg-danger">Blocked</span>'.html_safe
    when "in_review"
      '<span class="badge bg-warning text-dark">In Review</span>'.html_safe
    when "complete"
      '<span class="badge bg-success">Complete</span>'.html_safe
    else
      '<span class="badge bg-dark">Unknown</span>'.html_safe
    end
  end
end
