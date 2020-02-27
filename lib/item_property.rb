class ItemProperty
  MAX_QUALITY = 50

  def increase_quality(amount)
    self.quality += amount if self.quality < MAX_QUALITY
  end
end