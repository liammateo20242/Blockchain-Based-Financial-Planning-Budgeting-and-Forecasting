# Decentralized Operations Maintenance Management System

A blockchain-based maintenance management system built with Clarity smart contracts for the Stacks blockchain. This system provides decentralized management of operations, work orders, preventive maintenance, emergency response, and cost tracking.

## Features

### 🔐 Operations Manager Verification
- Verify and manage operations managers
- Role-based access control
- Manager profile management

### 📋 Work Order Management
- Create and assign maintenance work orders
- Track work order status and progress
- Priority-based task management

### 🔄 Preventive Maintenance
- Schedule recurring maintenance tasks
- Automated maintenance due date tracking
- Equipment-based maintenance planning

### 🚨 Emergency Response
- Report and manage emergency maintenance requests
- Severity-based prioritization
- Real-time emergency assignment and resolution

### 💰 Cost Tracking
- Track maintenance expenses and budgets
- Department-wise budget allocation
- Real-time budget monitoring

## Smart Contracts

### 1. Operations Manager Contract (\`operations-manager.clar\`)
Manages verification and authorization of operations managers.

**Key Functions:**
- \`verify-manager\`: Add a new verified manager
- \`revoke-manager\`: Remove manager verification
- \`is-verified-manager\`: Check manager verification status

### 2. Work Order Contract (\`work-order.clar\`)
Handles creation and management of maintenance work orders.

**Key Functions:**
- \`create-work-order\`: Create new work order
- \`update-work-order-status\`: Update work order status
- \`get-work-order\`: Retrieve work order details

### 3. Preventive Maintenance Contract (\`preventive-maintenance.clar\`)
Manages scheduled preventive maintenance tasks.

**Key Functions:**
- \`create-maintenance-schedule\`: Schedule preventive maintenance
- \`complete-maintenance\`: Mark maintenance as completed
- \`is-maintenance-due\`: Check if maintenance is due

### 4. Emergency Response Contract (\`emergency-response.clar\`)
Handles emergency maintenance requests and responses.

**Key Functions:**
- \`report-emergency\`: Report emergency situation
- \`assign-emergency\`: Assign emergency to responder
- \`resolve-emergency\`: Mark emergency as resolved

### 5. Cost Tracking Contract (\`cost-tracking.clar\`)
Tracks maintenance costs and manages budgets.

**Key Functions:**
- \`set-total-budget\`: Set overall budget
- \`record-expense\`: Record maintenance expense
- \`get-remaining-budget\`: Check remaining budget

## Installation

1. Clone the repository
2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### Deploying Contracts

Deploy the contracts to the Stacks blockchain in the following order:
1. \`operations-manager.clar\`
2. \`work-order.clar\`
3. \`preventive-maintenance.clar\`
4. \`emergency-response.clar\`
5. \`cost-tracking.clar\`

### Basic Workflow

1. **Setup**: Deploy contracts and verify operations managers
2. **Work Orders**: Create work orders for maintenance tasks
3. **Preventive Maintenance**: Schedule recurring maintenance
4. **Emergency Response**: Handle urgent maintenance issues
5. **Cost Tracking**: Monitor expenses and budgets

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract function calls
- Error handling
- Data validation
- State management

## Error Codes

### Operations Manager Contract
- \`u100\`: Owner only access
- \`u101\`: Unauthorized access
- \`u102\`: Manager already verified
- \`u103\`: Manager not verified

### Work Order Contract
- \`u200\`: Unauthorized access
- \`u201\`: Invalid status
- \`u202\`: Work order not found

### Preventive Maintenance Contract
- \`u300\`: Unauthorized access
- \`u301\`: Schedule not found
- \`u302\`: Invalid interval

### Emergency Response Contract
- \`u400\`: Unauthorized access
- \`u401\`: Emergency not found
- \`u402\`: Invalid severity

### Cost Tracking Contract
- \`u500\`: Unauthorized access
- \`u501\`: Insufficient budget
- \`u502\`: Invalid amount

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Security Considerations

- All contracts implement proper access controls
- Input validation is performed on all public functions
- Budget constraints are enforced in cost tracking
- Emergency severity levels are validated

## Future Enhancements

- Integration with IoT sensors for automated maintenance triggers
- Mobile app for field technicians
- Advanced reporting and analytics
- Integration with external maintenance systems
