# 失敗したジョブをキューから削除しない
Delayed::Worker.destroy_failed_jobs = false

# ログの設定
file_num = 5 # 保持するファイル数
max_size = 4 * Integer::MEGABYTE # 1ファイルあたりのサイズ
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'), file_num, max_size)


