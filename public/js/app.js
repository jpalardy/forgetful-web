
function pluralize(count, singular, plural) {
  plural = plural || singular + 's';
  return count === 1 ? singular : plural;
}

//-------------------------------------------------

var quizzes;

var controller = {};

controller.get_quizzes = function(filename) {
  $.getJSON("/quizzes.json", function(quizzes) {
    $('#quizzes').empty();
    $('#quizTemplate').tmpl(quizzes).appendTo('#quizzes');
  });
};

$(function() {
  controller.get_quizzes();

  $('#quizzes').delegate('.question a', 'click', function(e) {
    e.preventDefault();

    $(this).addClass('selected').
            siblings().
            removeClass('selected').
            parents('.question').
            addClass('answered').
            find('.hidden').
            removeClass('hidden');
  });

  $('#quizzes').delegate('.question', 'mouseenter', function() {
    $(this).addClass('selected');
  });
  $('#quizzes').delegate('.question', 'mouseleave', function() {
    $(this).removeClass('selected');
  });

  $('button.save').live('click', function() {
      var quiz = $(this).parents('.quiz');
      var filename = quiz.find('h2').text();

      var result = {};
      quiz.find('a.selected').each(function(i,elem) {
        var id    = $(elem).parents('.question').attr('data-id');
        var grade = parseInt($(elem).text(), 10);
        result[id] = grade;
      });

      $.post('/quizzes', {"filename": filename, "results": JSON.stringify(result)}, function(data) {
        var quizData = JSON.parse(data)[0];

        if(quizData) {
          quiz.replaceWith($('#quizTemplate').tmpl(quizData));
        } else {
          quiz.remove();
        }
      });
  });

  $(document).keyup(function(e) {
    var selected = $('.question.selected');

    if(e.keyCode >= 48 && e.keyCode <= 53) {
      var grade = e.keyCode - 48;
      selected.find("a:contains('" + grade + "')").click();
    }
  });
});


