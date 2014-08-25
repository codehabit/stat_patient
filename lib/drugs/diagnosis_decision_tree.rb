module Drugs
  class DiagnosisDecisionTree < Settingslogic
    source "#{Rails.root}/data/drugs/diagnosis_decision_tree.yml"
  end

  def path_for hsh, id
    path = ""
    hsh.each do |k, v|
      if v.is_a? Hash
        path << k
        path_for v, id
      elsif v == id
        return path
      else
        path = ''
      end
    end
    path
  end

end
