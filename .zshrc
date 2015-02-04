# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8

export LANG=en_US.UTF-8

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git perl tmux vagrant)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/ndn/dh/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set local preferred editor
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Do following only if not SSH session
fullname=`hostname -f 2>/dev/null || hostname`
case $fullname in
	*dreamhost.com) ;&
	*newdream.net)
	machine_type="$machine_type:ndn"
	;;
esac
if [[ $machine_type != ':ndn' ]]; then

# source perlbrew
source ~/perl5/perlbrew/etc/bashrc

# local::lib
#eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias yakko='ssh rmiller@yakko.sd.dreamhost.com -t tmux a'
alias fubar='ssh rmiller@fubar.dreamhost.com -t tmux a'
alias vi='vim'
alias gg='git grep -E'
ggm() { gg $* -- '*.pm' }
ggt() { gg $* -- '*.t' }
alias tstag='perl ~/ndn/dh/bin/leads/tstag.pl'
alias apachemove='/home/tngo/apachemove.sh'
alias dhe='sudo /dh/bin/dh-email'
alias rs='sudo /dh/bin/rsynctool'
alias siteperf='sudo /dh/bin/siteperformance -vv'
alias restorecheck='/home/anthonys/restore-check.sh'
alias procwatch='/home/anthonys/procwatch.sh'
alias hurtlocker='/home/anthonys/hurtlocker.sh'
alias dh-cluster='sudo /dh/bin/dh-cluster'
alias dh-db='sudo /dh/bin/dh-db'
alias dh-domain='sudo /dh/bin/dh-domain'
alias dh-ip='sudo /dh/bin/dh-ip'
alias dh-machine='sudo /dh/bin/dh-machine'
alias dh-watcher.pl='sudo /dh/bin/dh-watcher.pl'
alias dhd='sudo /dh/bin/dh-domain'
alias dhm='sudo /dh/bin/dh-machine'
alias dhsh.pl='sudo /dh/bin/dhsh.pl'
alias dip="sudo /dh/bin/dh-ip"
alias enableactt='sc yakko reenabler reenable'
alias epasswd.pl='sudo /dh/bin/epasswd.pl'
alias expedite='/home/brandon/homiemove.sh'
alias firewall.pl='sudo /dh/bin/firewall.pl'
alias ftptst='sudo /dh/bin/test_ftp'
alias loady.pl='sudo /dh/bin/loady.pl'
alias location-fix.pl='sudo /dh/bin/location-fix.pl'
alias mail_log_jumper='sudo /dh/bin/mail_log_jumper'
alias mlj='sudo /dh/bin/mail_log_jumper -t'
alias mljt='sudo /dh/bin/mail_log_jumper -t'
alias move.pl='sudo /dh/bin/move.pl'
alias movedata.pl='sudo /dh/bin/movedata.pl'
alias movemysql.pl='sudo /dh/bin/movemysql.pl'
alias movemysql_service.pl='sudo /dh/bin/movemysql_service.pl'
alias ndn-password='sudo /dh/bin/ndn-password'
alias ns='sudo /dh/bin/nsconfig'
alias nsconfig='sudo /dh/bin/nsconfig'
alias oc-up='sudo /dh/bin/servicectl yakko installer upgradenew'
alias pass='sudo /dh/bin/epasswd.pl -d'
alias reboot='/usr/local/ndn/dh/bin/reboot.pl'
alias rebooty.pl='sudo /dh/bin/rebooty.pl'
alias rsh='sudo rsh'
alias rssh='sudo /dh/bin/rssh'
alias sc='sudo /dh/bin/servicectl'
alias sctl='sudo /dh/bin/servicectl'
alias servicectl='sudo /dh/bin/servicectl'
alias sp='sudo /dh/bin/siteperformance -vv'
alias ssh='ssh -l root'
alias test-mail='sudo /dh/bin/test-mail'
alias getpass='sudo /dh/bin/test_password'
alias getusid='sudo /dh/bin/dh-email'
alias what-mounts='sudo /dh/bin/what-mounts'
alias wildcard-dns.pl='sudo /dh/bin/wildcard-dns.pl'
#Dev Aliases
DEV_ENV="/usr/bin/sudo /usr/bin/env DH_TEMPLATE_PREFIX=${HOME}/ndn PERL5LIB=${HOME}/ndn/perl "
alias mysc="${DEV_ENV} ${HOME}/ndn/dh/bin/servicectl"
alias scdb="${DEV_ENV} perl -d ${HOME}/ndn/dh/bin/servicectl"
alias domy="${DEV_ENV}"
alias scdb="/usr/bin/sudo /usr/bin/env PERL5DB='BEGIN { require \"perl5db.pl\"; push @DB::typeahead, \"b 813\"; }' DH_TEMPLATE_PREFIX=/home/rmiller/ndn PERLLIB=/home/rmiller/ndn/perl/ perl -d /home/rmiller/ndn/dh/bin/servicectl"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
