class Admin::CommunicationsController < Admin::AdminController
  before_action :set_communication, only: [:show, :edit, :update, :destroy, :deliver]

  def index
    @communications = Communication.all.order('created_at DESC')
  end

  def new
    @communication = Communication.new(sender: current_user)
  end

  def create
    @communication = Communication.new(communication_params)
    @communication.sender = current_user
    if @communication.save then
      redirect_to admin_communication_path(@communication), notice: t('.success')
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @communication.sent?
      redirect_to admin_communications_path, notice: 'Message was already sent!'
    end
  end

  def update
    @communication.update_attributes(communication_params)
    if @communication.save then
      redirect_to admin_communication_path(@communication), notice: 'Message updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @communication.destroy
    redirect_to admin_communications_path
  end

  def deliver
    if @communication.recipients.empty? then
      redirect_to admin_communication_path(@communication), notice: 'Message has no recipients assigned!'
      return
    end

    CommunicationsMailer.communication_mail(@communication).deliver
    @communication.update(sent_at: Time.zone.now)
    redirect_to admin_communication_path(@communication), notice: 'Mail sent successfully! You should also receive a copy.'
  end

private
  def set_communication
    @communication = Communication.find(params[:id])
  end
  def communication_params
    params.require(:communication).permit(:subject, :body, :recipients, :call_id)
  end
end
