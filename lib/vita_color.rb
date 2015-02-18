class VitaColor < ValueSet
  value_set %w{A1 A2 A3 A3.5 A4 B1 B2 B3 B4 C1 C2 C3 C4 D2 D3 D4 0M1  0M2 0M3}
  class << self
    def a_set
      all[0..4]
    end

    def b_set
      all[5..8]
    end

    def c_set
      all[9..12]
    end

    def d_set
      all[13..15]
    end
  end
end


