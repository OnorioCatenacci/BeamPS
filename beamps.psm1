<# 
# Erlang/Elixir Utility Powershell Funcs
#>

Set-Variable -name erlang_binary -value  "erl" -option Constant
Set-Variable -name no_beam_error_message -value "Cannot find erlang VM on this machine" -option Constant

function Get-ErlangMajorVersion
{
    & (Find-ErlangExecutable) -noshell -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -s init stop

}

function Get-ErlangFullVersion
{

    & (Find-ErlangExecutable) -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -s init stop

}
function Find-ErlangExecutable
{
    (Get-Command $erlang_binary | Select-Object source).Source
}


Export-ModuleMember Get-ErlangMajorVersion
