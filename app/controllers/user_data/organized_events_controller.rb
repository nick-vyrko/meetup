# frozen_string_literal: true

module UserData
  class OrganizedEventsController < ApplicationController
    def index
      @events = Event.where(user: current_user)
    end
  end
end
