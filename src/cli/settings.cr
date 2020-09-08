module Wafalyzer::CLI
  class Settings
    class_property colors = {
      :datetime => :dark_gray,
      :source   => :cyan,
      :metadata => :dark_gray,
    } of Symbol => Colorize::Color

    class_property severity_colors = {
      :trace  => :white,
      :debug  => :green,
      :info   => :blue,
      :notice => :dark_gray,
      :warn   => :light_red,
      :error  => :red,
      :fatal  => :magenta,
    } of ::Log::Severity => Colorize::Color
  end

  class_getter settings = Settings

  # Yields `settings` to the given block.
  def self.configure : Nil
    yield settings
  end
end
