module ParamsHelpers
  def permitted_params
    @permitted_params ||= declared(params, include_missing: false)
  end

  def dates_params
    {start_date: params[:start_date] || (Date.today - 7).to_s, end_date: params[:end_date] || Date.today.to_s}
  end
end
