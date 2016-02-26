module QuestionsHelper
  def closed_css_class(question)
    question.open? ? "question-new" : "question-closed"
  end
end
