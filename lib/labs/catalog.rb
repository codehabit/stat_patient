module Labs
  class Catalog < Settingslogic
    source "#{Rails.root}/data/labs/catalog.yml"
    def types
      self.items.keys.reject {|k| k == "lab_item"}
    end
  end
end

