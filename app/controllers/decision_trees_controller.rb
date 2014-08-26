class DecisionTreesController < ApplicationController
  include PathFinder

  def next_element
    @category = params[:category]
    @choices = choices_for @category
  end

  def build_element
    @category = params[:category] || 'top'
    @choices = choices_for @category
    @drug_uuid = params[:drug_uuid]

    if @leaf
      assign_diagnosis(drug_uuid: @drug_uuid, diagnosis_id: @leaf_id)
      @category = 'top'
      @choices = choices_for @category
    end

    tree = Drugs::DiagnosisDecisionTree
    @assignments = DrugDiagnosisAssignment.where(drug_uuid: @drug_uuid).order('created_at ASC').map do |assg|
      path_for tree, assg.diagnosis_id
    end
  end

  def remove_element
    @category = 'top'
    @choices = choices_for @category
    @drug_uuid = params[:drug_uuid]
    @diagnosis_id = params[:diagnosis_id]

    DrugDiagnosisAssignment.where(drug_uuid: @drug_uuid, diagnosis_id: @diagnosis_id).delete_all

    tree = Drugs::DiagnosisDecisionTree
    @assignments = DrugDiagnosisAssignment.where(drug_uuid: @drug_uuid).order('created_at ASC').map do |assg|
      path_for tree, assg.diagnosis_id
    end
  end

  def index
    @tree = YAML.load_file(File.join('data','drugs', 'diagnosis_decision_tree.yml'))
  end

  private

  def assign_diagnosis opts
    unless DrugDiagnosisAssignment.exists?(opts)
      DrugDiagnosisAssignment.create opts
    end
  end

  def choices_for chain
    tree = Drugs::DiagnosisDecisionTree
    results = chain.split('.').reduce(tree) {|memo, method| memo.send(method.to_sym)}

    if leaf? results
      @leaf = true
      @leaf_id = results.id
      DrugDiagnosisAssignment.where(diagnosis_id:@leaf_id).map(&:drug)
    else
      results
    end
  end

  def leaf? results
    results.keys == ['id']
  end

end
