# Add a user to a mail-enabled security group.
# -BypassSecurityGroupManagerCheck allows Exchange administrators
# to modify group membership without being listed as a group manager.

Add-DistributionGroupMember `
    -Identity "MailEnabledSecurityGroup" `
    -Member "user@example.com" `
    -BypassSecurityGroupManagerCheck
