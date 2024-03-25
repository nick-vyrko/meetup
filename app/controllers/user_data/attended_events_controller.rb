# frozen_string_literal: true

module UserData
  class AttendedEventsController < ApplicationController
    def index
      # @tickets = Ticket.where(user: current_user).group(:event_id).select('event_id, COUNT(*) as tickets_count').includes(:event)
      @events = Event.joins(:tickets)
                      .where(tickets: {user: current_user})
                      .group('events.id, events.name, events.datetime')
                      .select('events.id, events.name, events.datetime, COUNT(*) as tickets_count')
    end

    def show
      @tickets = Ticket.where(user_id: current_user.id, event_id: params[:id])
    end
  end
end
