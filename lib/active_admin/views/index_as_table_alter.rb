module ActiveAdmin
  module Views

    class IndexAsTableAlter < ActiveAdmin::Views::IndexAsTable
      def self.index_name
        "table_alter"
      end
    end

  end
end
