$type_of_test_question = $("question[question-key=type_of_test]")
$type_of_product_question = $("question[question-key=type_of_product]")
$type_of_test_question.on "change", "input", ()->
  $type_of_product_question.removeClass("hide")

