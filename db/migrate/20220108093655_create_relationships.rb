class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: { to_table: :users }#foreign_key: trueにすると存在しないfollowsテーブルを参照してしまう
      t.references :followed, foreign_key: { to_table: :users }#foreign_key: trueにすると存在しないfollowsテーブルを参照してしまう

      t.timestamps
    end
  end
end
