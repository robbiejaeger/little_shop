class CausesController < ApplicationController
  def show
    @cause = Cause.find_by(slug: params[:causes_slug])
    @recipients = @cause.active_recipients
  end
end
