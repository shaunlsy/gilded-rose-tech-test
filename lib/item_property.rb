class ItemProperty
  MAX_QUALITY = 50
  DEFAULT_QUALITY_INCREASE = 1

  def increase_quality(amount=DEFAULT_QUALITY_INCREASE)
    self.quality += amount if self.quality < MAX_QUALITY
  end
end
