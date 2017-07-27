class ReferralsController < ApplicationController
  def index
  end

  def mark
    @referral = Referral.find_by_code(params[:referral_code])
    if @referral && @referral.resolve!
      redirect_to confirmed_referrals_path
    else
      redirect_to referrals_path(not_found: "t")
    end
  end

  def confirmed
  end

end
