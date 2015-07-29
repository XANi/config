class dev::nodejs {
    package {[
              'nodejs'
              'nodejs-legacy', # for node -> nodejs symlink
              'npm',
              ]:
                  ensure => latest

    }
}
