module ApplicationHelper
  def class_for(task)
    clazz = [ 'task' ]
    if task.done?
      clazz << 'done'
    end

    clazz.join(' ')
  end

  def task_list_for(label, items, context_class, link_path)
    content_tag :article, class: "task-list #{context_class}" do
      content = "<h2>#{link_to label, link_path, class: 'text-info'}</h2>"
      content += "<table class='table table-hover'>
                  <tbody>"

      items.map do |list|
        content += content_tag :tr do
          link = link_to(list.name, list_path(list), class: 'list-link')
          content_tag :td, link, class: "list#{ ' public' if list.public? }".html_safe
        end.html_safe
      end.join.html_safe

      content += "</tbody>
              </table>"

      content.html_safe
    end.html_safe
  end
end
