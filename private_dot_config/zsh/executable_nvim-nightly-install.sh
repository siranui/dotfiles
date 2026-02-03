# !/bin/zsh

# 最新のnightly版neovimを取得する
function get_nvim_latest_nightly() {
	case ${OSTYPE} in
		darwin*) # Mac OSの場合

			local LOCAL_BIN="/usr/local/bin" # nightly版nvimを置く場所。
			local app_name="nvim-nightly"
			local app_path="$LOCAL_BIN/$app_name"

			mkdir -p $LOCAL_BIN
			rm -rf $LOCAL_BIN/$app_name

			local LOCAL_SHARE="/usr/local/share" # runtimeを置く場所
			local share_name="nvim"
			local runtime_path="$LOCAL_SHARE/$share_name" # runtimeを置く場所
			rm -rf $LOCAL_SHARE/$share_name

			curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
			tar xzf nvim-macos-arm64.tar.gz

			mv nvim-macos-arm64/bin/nvim $app_path
			mv nvim-macos-arm64/share/nvim $runtime_path

			rm -rf nvim-macos-arm64
			rm -rf nvim-macos-arm64.tar.gz
			;;

		linux*) # Linuxの場合
			;;
	esac
}
get_nvim_latest_nightly
