class PatientParams
  def initialize(incoming)
    @params = incoming
    convert_parts_to_birthdate
    convert_parts_to_social_security_number
  end

  def convert_parts_to_social_security_number
    pre = @params[:social_pre]
    mid = @params[:social_mid]
    suffix = @params[:social_suffix]
    if pre.present? && mid.present? && suffix.present?
      @params[:patient][:social_security_number] = "#{pre}-#{mid}-#{suffix}"
    end
  end

  def convert_parts_to_birthdate
    day = @params[:day_of_birth]
    month = @params[:month_of_birth]
    year = @params[:year_of_birth]
    if day.present? && month.present? && year.present?
      @params[:patient][:date_of_birth] = DateTime.new(year.to_i, month.to_i, day.to_i)
    end
  end

  def as_hash
    @params
  end
end

