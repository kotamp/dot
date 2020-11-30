# source : https://github.com/Phantas0s/.dotfiles/blob/master/zsh/scripts.zsh

extract() {
  if [ -f $1 ] ; then
    ex $1
  else
    echo "'$1' is not a valid file"
  fi
}

mkextract() {
  for file in "$@"
  do
    local filename=${file%\.*}
    if [ ! -f $file ]; then
      echo "'$file' is not a file - ignoring..."
    elif [ "$(ex_is_archive $file)" -ne 0 ]; then
      echo "'$file' is not an archive - ignoring..."
    elif [ -d "$filename" ]; then
      echo "'$file' folder exists - ignoring..."
    else
      mkdir -p $filename
      cp $file $filename
      cd $filename
      ex $file
      local result=$?
      rm -f $file
      cd -
      if [ $? -ne 0 ]; then
        rmdir $filename --ignore-fail-on-non-empty
      fi
    fi
  done
}

ex() {
  case $1 in
    *.tar.bz2) tar xjf    $1 ;;
    *.tar.gz)  tar xzf    $1 ;;
    *.bz2)     bunzip2    $1 ;;
    *.gz)      gunzip     $1 ;;
    *.tar)     tar xf     $1 ;;
    *.tbz2)    tar xjf    $1 ;;
    *.tgz)     tar xzf    $1 ;;
    *.zip)     unzip      $1 ;;
    *.7z)      7z x       $1 ;;
    *.rar)     7z x       $1 ;;
    *.iso)     7z x       $1 ;;
    *.Z)       uncompress $1 ;;
    *)         echo "'$1' cannot be extracted" ;;
  esac
}

ex_is_archive() {
  case $1 in
    *.tar.bz2) ;&
    *.bz2)     ;&
    *.tar.gz)  ;&
    *.bz2)     ;&
    *.gz)      ;&
    *.tar)     ;&
    *.tbz2)    ;&
    *.tgz)     ;&
    *.zip)     ;&
    *.7z)      ;&
    *.rar)     ;&
    *.iso)     ;&
    *.Z)       echo 0 ;;
    *)         echo 1 ;;
  esac
}

