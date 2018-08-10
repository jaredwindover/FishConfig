set -gx PATH $HOME/Development/config_files/bin $PATH
set -gx PATH $HOME/Development/topsoil/bin $PATH
set -gx PATH $HOME/.rvm/bin $PATH

set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home"

set -gx PYTHONPATH (brew --prefix)"/lib/python2.7/site-packages"
set -gx PYTHONPATH "/opt/salt/lib/python2.7/site-packages:"$PYTHONPATH
