#/bin/sh

readonly TEST_NSLOOKUP_CMD="nslookup"

test_with_nslookup(){
  nslookup live.rdv.bb 0.0.0.0 > /dev/null 2>&1
  if [[ ${?} -eq 0 ]]
  then
    echo "test nslookup : Ok"
  else 
    echo " test nslookup : ko"
  fi
}

usage(){
  local scriptName=$(basename "${0}")
  echo "* ${scriptName} ${TEST_NSLOOKUP_CMD}"
  echo "    name resolution with nslookup"
}

if [[ ${#} -eq 0 ]]
then
  usage
  exit -1
fi

didSomething=0

if [[ "${1}" == "${TEST_NSLOOKUP_CMD}" ]]
then
  test_with_nslookup
  didSomething=1
fi

if [[ ${didSomething} -eq 0 ]]
then
  usage
  exit -1
fi
