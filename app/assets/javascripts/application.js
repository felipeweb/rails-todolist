// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
$(function(){
    var checkboxChanged = function() {
        var $task = $(this).parents('.task'),
            url = $task.data('url');

        if (this.checked) {
            $.ajax({
                url: url,
                type: 'PUT',
                data: { done: true },
                dataType: 'json'
            }).then(function(data) {
                $task.addClass('done');
            })
        } else {
            $.ajax({
                url: url,
                type: 'PUT',
                data: { done: false },
                dataType: 'json'
            }).then(function(data) {
                $task.removeClass('done');
            })
        }
    }

    $("li>input[type='checkbox']").change(checkboxChanged)

    $('#favorite').change(function() {
        url = $(this).data('url');
        id = $(this).attr('value');

        if (this.checked) {
            $.ajax({
                url: '/lists/' + id + '/favorite'
            });
        } else {
            $.ajax({
                url: '/lists/' + id + '/unfavorite'
            });
        }
    });

    $('#public_list').change(function() {
        url = $(this).data('url');
        id = $(this).attr('value');

        if (this.checked) {
            $.ajax({
                url: '/lists/' + id + '/mark_public_list'
            });
        } else {
            $.ajax({
                url: '/lists/' + id + '/unmark_public_list'
            });
        }
    });
    $('#list_tasks_name').on('keydown', function(event) {
        if (event.keyCode === 13) {
            taskName = $(this).val();
            url = $('.tasks').data('url');
            $li = $('<li>').attr('class', 'task');
            $checkbox = $('<input type="checkbox">');

            $.post(url, { name: taskName }, 'json').then(function(data) {
                $li.attr('data-url', data.url);
                $li.append($checkbox);
                $li.append(' ' + data.name);
                $checkbox.change(checkboxChanged);

                $('.new_task')[0].value = '';
                $('.tasks>ul').append($li);
            }, function(data) {
                $('.error').remove()
                $span = $('<span>').attr('class', 'error')
                errors = data.responseJSON.errors

                errors.forEach(function(errorMsg) {
                    $('.simple_form').append($span.text(errorMsg))
                })
            });

            return false
        };
    });
});
