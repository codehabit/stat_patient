class DecisionTreesController < ApplicationController

  def next_element
    @category = params[:category]
    @choices = choices_for @category
  end

  def index
    @tree = YAML.load_file(File.join('data','drugs', 'diagnosis_decision_tree.yml'))
  end

  private

  def choices_for chain
    tree = Drugs::DiagnosisDecisionTree
    results = chain.split('.').reduce(tree) {|memo, method| memo.send(method.to_sym)}

    if leaf? results
      @leaf = true
      DrugDiagnosisAssignment.where(diagnosis_id: results.id).map(&:drug)
    else
      results
    end
  end

  def leaf? results
    results.keys == ['id']
  end

end
