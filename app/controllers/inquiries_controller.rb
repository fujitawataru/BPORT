class InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.invalid? #なぜinvalidメソッド？
       render :new
    end
  end

  def back
    @inquiry = Inquiry.new(inquiry_params)
    render :new
  end

  def create
    @inquiry =Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email,:name,:phone_number,:subject,:message)
  end
end
