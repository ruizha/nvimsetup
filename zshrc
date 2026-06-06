# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:~/.local/bin:~/gitcmds:/usr/local/go/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
export ANDROID_HOME="$HOME/Android/Sdk"


export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

EDITOR='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vim='nvim'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

function swapcaps() {
	if [[ $1 == 'true' ]]; then
		sudo localectl set-x11-keymap us "" "" ctrl:swapcaps
	elif [[ $1 == 'false' ]]; then
		sudo localectl set-x11-keymap us "" "" ""
	fi
	# force reload input subsystem to apply above changes w/o logout/restart
	udevadm trigger --subsystem-match=input --action=change
}

function gmi() {
	if [[ $1 == 'update' ]]; then
		npm install -g @google/gemini-cli@latest
	else
		gemini
	fi
}

function dd2d() {
	read "file?File to write: "
	read "dest?Destination: "
	read "confirm?Writing $file to $dest. Confirm (y/n): "
	if [[ $confirm == 'y' ]]; then
		sudo dd bs=4M if=$file of=$dest status=progress oflag=sync
	else
		echo "Cancelling operation. Goodbye."
	fi
}

function gh() {
	if [[ $1 == 'ac' ]]; then
		git add -A
		git commit -m $2
	fi
}

function pbc() {
	cat $1 | pbcopy
}


function mdp() {
  echo $1 | COLUMNS=80 entr -c mdcat /_
}

alias rc='source ~/.zshrc'
alias yay-clean='sudo pacman -Rns $(yay -Qdtq)'
alias ze='vim ~/.zshrc'
alias zep='vim ~/.personal.zsh'
alias kill-gvfs='kill $(pgrep gvfsd-metadata) && rm -rf ~/.local/share/gvfs-metadata/'
alias ff='fastfetch'
alias pbcopy='xclip -selection clipboard'
alias gitc='git checkout'
alias lg='lazygit'
alias ssh-pandora="ssh -i $HOME/.ssh/pandora 'rayzhang@pandora.local'"
alias gdp='cd ~/GodotProjects'

alias c46='claude --model claude-opus-4-6'

if [[ -e /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
fi

export ENABLE_CORRECTIOn="false"
unsetopt correct
unsetopt correct_all
unsetopt correctall

if [[ -e ~/.secrets ]]; then
    source ~/.secrets
fi

if [[ -e ~/.corpa ]]; then
    source ~/.corpa.zsh
fi

if [[ -e ~/.personal ]]; then
    source ~/.personal.zsh
fi

export FZF_DEFAULT_OPTS="--height 75% --style full --preview 'fzf-preview.sh {}' \
    --bind 'ctrl-j:down,ctrl-k:up' \
    --bind 'ctrl-n:down+down+down+down+down+down+down+down+down+down' \
    --bind 'ctrl-i:up+up+up+up+up+up+up+up+up+up' \
    --layout=reverse \
    --walker-skip .git,.github,.idea,.helm,.qlty,.ruby-lsp,bin,tmp"

func fz() {
    root_dir=$(git rev-parse --show-toplevel)
    if [[ $1 != '' ]]; then
        root_dir=$1
    fi
    target=$(fzf --walker-root=$root_dir)
    if [[ $target != '' ]]; then
        nvim $target
    fi
}

function pin() {
	if [[ ! -f $HOME/.pbklist ]]; then
		touch $HOME/.pbklist
	fi
	if [[ $1 == "" ]]; then
		echo "Please specify 'mark', 'rm', 'clearall', 'list', 'find', or a label"
	elif [[ $1 == "mark" || $1 == "mk" || $1 == "s" ]]; then
		pin rm $2 # delete entry if it already exists
		echo $2::$(pwd) >> $HOME/.pbklist
	elif [[ $1 == "rm" ]]; then
		for i in {2.."$#"}; do
			sed -i '' "/$@[i]::/d" $HOME/.pbklist
		done
	elif [[ $1 == "l" || $1 == "list" ]]; then
		cat $HOME/.pbklist
	elif [[ $1 == "clearall" ]]; then
		rm $HOME/.pbklist
		touch $HOME/.pbklist
	elif [[ $1 == "find" ]]; then
		grep -i "$2" $HOME/.pbklist
	else
		mkr=$(grep "$1::" $HOME/.pbklist)
		if [[ mkr == "" ]]; then
			echo "No bookmark $1 found"
		else
			cd ${mkr//$1:://}
		fi
	fi
}

alias ytdd='yt-dlp --trim-filenames 30 $1' 
