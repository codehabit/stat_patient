class LiveState
  class << self
    @@state = {}
    def latest(practitioner_id)
      @@state[practitioner_id]
    end

    def register_latest(practitioner_id, cases)
      @@state[practitioner_id] = cases
    end

    def diff(practitioner_id, cases)
      current = @@state[practitioner_id]
      current_hash = {}.tap {|memo| current.each {|c| memo[c.id] = c}}
      incoming_hash = {}.tap {|memo| cases.each {|c| memo[c.id] = c}}
      candidates = cases - current
      candidates.tap do |memo|
        current_hash.each do |k,v|
          candidate_for_diff = incoming_hash[k]
          if candidate_for_diff.updated_at > v.updated_at
            memo << candidate_for_diff
          end
        end
      end
    end
  end
end

