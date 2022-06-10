defmodule FestifyPromotion.Controls do
  defmodule Time do
    def example do
      DateTime.new!(~D[2000-01-01], ~T[00:00:00.000000])
    end
  end

  defmodule Id do
    def example do
      "00000000-0000-0000-0000-00000000000a"
    end

    def generate do
      Ecto.UUID.generate()
    end
  end
end
