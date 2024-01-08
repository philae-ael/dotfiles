TRAPUSR1() {
    rehash
} 
precmd() {
    killall -USR1 zsh
}
