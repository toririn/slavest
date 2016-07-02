module EmovalueOptionDecorator

  def select_options(type, options = nil)
    settings = EasySettings.models.emovalue_option[type]
    keys     = settings.set_values.keys
    select_map(settings, keys, options)
  end

  def select_map(settings, keys, options=nil)
    if options
      keys.map do |key|
        [ settings.displays[key], settings.set_values[key], options ]
      end
    else
      keys.map do |key|
        [ settings.displays[key], settings.set_values[key] ]
      end
    end
  end

  def value_use_take
    use_take ? 1:0
  end

  def display_use_take
    displays = EasySettings.models.emovalue_option.use_take.displays
    case use_take
    when true
      displays.accept
    when false
      displays.refuse
    else
      displays.refuse
    end
  end


  def display_decrease
    displays = EasySettings.models.emovalue_option.decrease.displays
    case notification_decrease
    when 0
      displays.refuse
    when 1
      displays.often
    when 2
      displays.occasionally
    else
      displays.refuse
    end
  end

  def display_increase
    displays = EasySettings.models.emovalue_option.increase.displays
    case notification_increase
    when 0
      displays.refuse
    when 1
      displays.often
    when 2
      displays.occasionally
    else
      displays.refuse
    end
  end

  def display_slowdown
    displays = EasySettings.models.emovalue_option.slowdown.displays
    case notification_slowdown
    when 0
      displays.refuse
    when 1
      displays.often
    when 2
      displays.occasionally
    else
      displays.refuse
    end
  end

  def display_regular
    displays = EasySettings.models.emovalue_option.regular.displays
    case notification_regular
    when 0
      displays.refuse
    when 1
      displays.mo_no_ni
    when 2
      displays.mo
    when 3
      displays.no
    when 4
      displays.ni
    when 5
      displays.mo_no
    when 6
      displays.mo_ni
    when 7
      displays.no_ni
    else
      displays.refuse
    end
  end

  def display_push_guide
    displays = EasySettings.models.emovalue_option.push_guide.displays
    case notification_push_guide
    when 0
      displays.refuse
    when 1
      displays.assept
    else
      displays.refuse
    end
  end
end
