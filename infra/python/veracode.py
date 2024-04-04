import json
import sys
from veracode_api_py import Applications, SummaryReport

appname = sys.argv[1]

application_id = Applications().get_by_name(appname=appname)
application_guid = application_id[0]['guid']

summary = SummaryReport().get_summary_report(app=application_guid)
severity = {'INFORMATIONAL': 0, 'LOW': 0, 'MEDIUM': 0, 'HIGH': 0, 'CRITICAL': 0}
severity['COMPLIANCE_STATUS'] = summary['policy_compliance_status']
severity['TOTAL_FLAWS'] = summary['total_flaws']
severity['FLAWS_NOT_MITIGATED'] = summary['flaws_not_mitigated']
severity['POLICY_NAME'] = summary['policy_name']
severity['ANALYSIS_SCORE'] = summary['static-analysis']['score']
severity['ANALYSIS_RATING'] = summary['static-analysis']['rating']

for k, v in severity.items():
    for category in summary['severity']:
        for name in category['category']:
            if name['count'] > 0 and name['severity'] == k:
                severity[name['severity']] += name['count']

print(json.dumps(severity))