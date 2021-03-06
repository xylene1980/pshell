#describe 'Check URL Path' {
#  $result = "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-x64.exe"
#  it 'should return True' {
#    $result | should be "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-x64.exe"
#  }
#}

describe 'Test JAVA installation' {
  $out=&"javac.exe" -version 2>&1
  $version = $out[0].toString().SubString(6,3)
  it 'should not be 1.5' {
    $version | should -Not -Be 1.5
  }
}

describe 'Git installation Check' {
  $out=&"git.exe" --version 2>&1
  $version = $out.toString().SubString(0,14)
  it 'should return git version 2.' {
    $version | should be "git version 2."
  }
}

describe "JDK check, no JRE" {
  $out=&"javac.exe" -version 2>&1
  $version = $out[0].toString().SubString(0,5)
  context "JDK check" {
    it 'should not be 1.5' {
      $version | should -Not -Be 1.5
    }
    $out1=&"java.exe" -version 2>&1
    $actual=$out1[1].toString().SubString(33,11)
    it 'should return java as not recognized command' {
      $actual | should beexactly "build 1.8.0"
    }
    it 'should return JRE Found' {
      $actual | should be 'build 1.8.0'
    }
  }
}

describe 'Test-Path' {
  $output = (Get-CimInstance -Class win32_computersystem).UserName
  $uname = $output.SubString($output.LastIndexOf('\')+1)
  $path = "C:\Users\$uname\.gitconfig"
  $value = Test-Path "C:\Users\$uname\.gitconfig"
  it 'should return gitconfig file is there' {
    $value | should be True
  }

  # it 'should check proxy settings' {
  #   $path | should Contain 'http://165.225.104.34:9480'
  # }

  it 'should have user' {
    $path | should -FileContentMatch 'user'
  }

  it 'should have email' {
    $path | should -FileContentMatch "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
  }
}
