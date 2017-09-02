class OrderProductSerializer < ProductSerializer
  cache

  def cache_key
    [object, scope]
  end

  def include_user?
    false
  end
end
