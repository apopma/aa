class EmptySquare
  def to_s
    " "
  end

  def color
    :empty
  end

  def empty?
    true
  end

  def king?
    false
  end

  def move_diffs
    []
  end

  def inspect
    "`"
  end

  def dup(_)
    self #EmptySquare.new if this breaks
  end
end
