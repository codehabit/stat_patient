module PathFinder
  def all_paths(hash, path = "")
    hash.each_with_object({}) do |(k, v), ret|
    key = path + k

      if v.is_a? Hash
        ret.merge! all_paths(v, key + ".")
      else
        ret[v] = key
      end
    end
  end

  def path_for hsh, id
    [id, all_paths(hsh)[id].gsub('.id','').gsub('top.','')]
  end
end
