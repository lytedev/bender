defmodule Bender.EventReaction do
  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
      use GenEvent

      def respond(message, {session, %{room: room}}) do
        Matrix.Client.post!(session, room, message)
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def handle_event(_, parent) do
        {:ok, parent}
      end

      def get_help_message(description) do
        "#{inspect(__MODULE__)}: #{description}"
      end
    end
  end
end
