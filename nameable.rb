class Nameable
  def correct_name
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end
