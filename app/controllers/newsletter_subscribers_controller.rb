class NewsletterSubscribersController < ApplicationController

  def new
    @newsletter = NewsletterSubscriber.new
  end

  def create
   @newsletter =  NewsletterSubscriber.create(params[:email])
   redirect_to faqs_path
  end
end
