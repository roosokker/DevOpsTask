import re

def is_routable_fqdn_email(email):
    if not email or not email.strip():
        return {'valid': False, 'reason': 'missing_email'}
    
    email = email.strip()
    
    # First check for non-routable domains (like localhost) before format validation
    domain = email.split('@')[1] if '@' in email else ""
    
    # List of non-routable domains
    non_routable = [
        'localhost', 'localdomain', 'local', 
        'example.com', 'test.com', 'invalid.com',
        'example.org', 'test.org', 'example.net'
    ]
    
    if domain.lower() in non_routable:
        return {'valid': False, 'reason': 'non_routable_email'}
    
    # check email format
    email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    if not re.match(email_pattern, email):
        return {'valid': False, 'reason': 'invalid_format'}
    
    return {'valid': True, 'reason': 'valid'}


def id_value(user_id):
    try:
        id_num = int(user_id)
        return {'valid': True, 'value': "even" if id_num % 2 == 0 else "odd"}
    except (ValueError, TypeError):
        return {'valid': False, 'reason': 'missing_id'}


with open('user_data.txt', 'r') as file:
    header = file.readline()
    
    for line in file:
        line = line.strip()
        if line:
            parts = [part.strip() for part in line.split(',')]
            
            name = parts[0] if len(parts) > 0 else ""
            email = parts[1] if len(parts) > 1 else ""
            user_id = parts[2] if len(parts) > 2 else ""

            check_id = id_value(user_id)
            check_mail = is_routable_fqdn_email(email)

            if check_id['valid'] and check_mail['valid']:
                print(f'The {user_id} of {email} is {check_id["value"]} number.')
            else:
                if not check_id['valid'] and not check_mail['valid']:
                    print(f"WARNING: Invalid parameters - {check_id['reason']} and {check_mail['reason']}s for user {name}")
                elif not check_id['valid']:
                    print(f"WARNING: Invalid parameters - {check_id['reason']} for user {name}")
                elif not check_mail['valid']:
                    print(f"WARNING: Invalid parameters - {check_mail['reason']} for user {name}")