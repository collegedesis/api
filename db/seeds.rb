OrganizationType.create(category:"cultural",  name: 'Indian')
OrganizationType.create(category:"cultural",  name: 'Pakistani')
OrganizationType.create(category:"cultural",  name: 'Bangladeshi')
OrganizationType.create(category:"cultural",  name: 'South Asian')

OrganizationType.create(category:"cultural",  name: 'Publication')

OrganizationType.create(category:"religious", name: 'Hindu')
OrganizationType.create(category:"religious", name: 'Muslim')
OrganizationType.create(category:"religious", name: 'Sikh')

OrganizationType.create(category:"dance",     name: 'Raas')
OrganizationType.create(category:"dance",     name: 'Bhangra')
OrganizationType.create(category:"dance",     name: 'Fusion')
OrganizationType.create(category:"dance",     name: 'Classical')

OrganizationType.create(category:"music",  name: 'A Cappella')
OrganizationType.create(category:"music",  name: 'Classical')
OrganizationType.create(category:"music",  name: 'Band')

OrganizationType.create(category:"greek",  name: 'Greek')

OrganizationType.create(category:"event",  name: 'Conference')
OrganizationType.create(category:"event",  name: 'Competition')

OrganizationType.create(category:"sport",     name: 'Cricket')

MembershipType.create(name: "Member", internal_ref: MEMBERSHIP_TYPE_MEMBER)
MembershipType.create(name: "Admin", internal_ref: MEMBERSHIP_TYPE_ADMIN)