require 'discordrb/events/generic'
require 'discordrb/data'

module Discordrb::Events
  class ChannelCreateEvent
    attr_reader :type
    attr_reader :topic
    attr_reader :position
    attr_reader :name
    attr_reader :is_private
    attr_reader :id
    attr_reader :server

    def initialize(data, bot)
      @type = data['type']
      @topic = data['topic']
      @position = data['position']
      @name = data['name']
      @is_private = data['is_private']
      @id = data['id']
      @server = bot.server(data['guild_id'].to_i)
    end
  end

  class ChannelCreateEventHandler < EventHandler
    def matches?(event)
      # Check for the proper event type
      return false unless event.is_a? ChannelCreateEvent

      return [
        matches_all(@attributes[:type], event.type) do |a,e|
          if a.is_a? String
            a == e.name
          else
            a == e
          end
        end,
        matches_all(@attributes[:name], event.name) do |a,e|
          if a.is_a? String
            a == e.to_s
          else
            a == e
          end
        end
      ].reduce(true, &:&)
    end
  end
end
