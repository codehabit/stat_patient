module Drugs
  class Formulary < Settingslogic
    source "#{Rails.root}/data/drugs/formulary.yml"
    def categories
      self.items.keys
    end
  end
end


