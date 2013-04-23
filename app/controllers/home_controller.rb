class HomeController < ApplicationController
  def index
    @organizers = User.organizing_events
    @talkers = User.presentation_events
    @participations = User.participation_events
    @groups = Group.participation_events
    @talks = Talk.presentation_events
    @events = Event.present_users
  end
end